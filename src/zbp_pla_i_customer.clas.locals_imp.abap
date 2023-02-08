CLASS lhc_Customer DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Customer RESULT result.

    METHODS earlynumbering_cba_address FOR NUMBERING
      IMPORTING entities FOR CREATE customer\_address.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE customer.

ENDCLASS.

CLASS lhc_Customer IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA:
      entity         TYPE STRUCTURE FOR CREATE zpla_i_customer,
      max_customerid TYPE zpla_customer_id.

    LOOP AT entities INTO entity WHERE CustomerId IS NOT INITIAL.
      APPEND CORRESPONDING #( entity ) TO mapped-customer.
    ENDLOOP.

    DATA(entities_wo_customerid) = entities.
    DELETE entities_wo_customerid WHERE CustomerId IS NOT INITIAL.

    SELECT SINGLE
            FROM  zpla_d_customer
            FIELDS MAX( customer_id ) AS CustomerId
            INTO @max_customerid.

    LOOP AT entities_wo_customerid INTO entity.
      max_customerid += 1.
      entity-CustomerId = max_customerid .

      APPEND VALUE #( %cid  = entity-%cid
                      %key  = entity-%key
                    ) TO mapped-customer.
    ENDLOOP.
  ENDMETHOD.

  METHOD earlynumbering_cba_Address.
    DATA: max_addressid TYPE zpla_address_id.

    READ ENTITIES OF zpla_i_customer IN LOCAL MODE
      ENTITY customer BY \_address
        FROM CORRESPONDING #( entities )
        LINK DATA(addresses).

    SELECT SINGLE
        FROM  zpla_d_address
        FIELDS MAX( address_id ) AS AddressId
        INTO @max_addressid.

    " Loop over all unique CustomerIDs
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<customer_group>) GROUP BY <customer_group>-CustomerId.
      " Loop over all entries in entities with the same CustomerlID
      LOOP AT entities ASSIGNING FIELD-SYMBOL(<customer>) USING KEY entity WHERE CustomerId = <customer_group>-CustomerId.
        " Assign new AddressIDs if not already assigned
        LOOP AT <customer>-%target ASSIGNING FIELD-SYMBOL(<address_wo_numbers>).
          APPEND CORRESPONDING #( <address_wo_numbers> ) TO mapped-address ASSIGNING FIELD-SYMBOL(<mapped_address>).
          IF <address_wo_numbers>-AddressId IS INITIAL.
            max_addressid += 1.
            <mapped_address>-AddressId = max_addressid .
          ENDIF.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
