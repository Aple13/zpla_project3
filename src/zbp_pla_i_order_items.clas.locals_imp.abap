CLASS lhc_OrderItems DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS calculateItemSubtotal FOR DETERMINE ON MODIFY
      IMPORTING keys FOR OrderItems~calculateItemSubtotal.

    METHODS validateItem FOR VALIDATE ON SAVE
      IMPORTING keys FOR OrderItems~validateItem.

    METHODS validateQty FOR VALIDATE ON SAVE
      IMPORTING keys FOR OrderItems~validateQty.

ENDCLASS.

CLASS lhc_OrderItems IMPLEMENTATION.

  METHOD calculateItemSubtotal.

    READ ENTITIES OF zpla_i_order IN LOCAL MODE
    ENTITY OrderItems BY \_Order
      FIELDS ( OrderUUID )
      WITH CORRESPONDING #( keys )
      RESULT DATA(Items)
      FAILED DATA(read_failed).

    MODIFY ENTITIES OF zpla_i_order IN LOCAL MODE
    ENTITY Order
      EXECUTE recalctotalprice
      FROM CORRESPONDING #( Items )
    REPORTED DATA(execute_reported).

    reported = CORRESPONDING #( DEEP execute_reported ).
  ENDMETHOD.

  METHOD validateItem.
      READ ENTITIES OF zpla_i_order IN LOCAL MODE
      ENTITY Orderitems
        FIELDS ( ItemId OrderUuid ) WITH CORRESPONDING #( keys )
      RESULT DATA(orderitems).

    DATA items TYPE SORTED TABLE OF zpla_d_item WITH UNIQUE KEY item_id.

    items = CORRESPONDING #( orderitems DISCARDING DUPLICATES MAPPING item_id = ItemId EXCEPT * ).
    DELETE items WHERE item_id IS INITIAL.

    IF items IS NOT INITIAL.
     SELECT FROM zpla_d_item FIELDS item_id
        FOR ALL ENTRIES IN @items
        WHERE item_id = @items-item_id
        INTO TABLE @DATA(items_db).
    ENDIF.

    LOOP AT orderitems ASSIGNING FIELD-SYMBOL(<ls_orderitem>).
      IF <ls_orderitem>-ItemId IS INITIAL OR NOT line_exists( items_db[ item_id = <ls_orderitem>-ItemId ] ).
        APPEND VALUE #(  %tky = <ls_orderitem>-%tky ) TO failed-orderitems.

        APPEND VALUE #(  %tky        = <ls_orderitem>-%tky
                         %state_area = 'VALIDATE_ORDERITEM'
                         %path       = VALUE #( Order-%is_draft = <ls_orderitem>-%is_draft
                                                Order-OrderUuid = <ls_orderitem>-OrderUuid )
                         %msg        = NEW zcm_pla_project3(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_pla_project3=>item_unknown
                                           itemid     = <ls_orderitem>-ItemId )
                         %element-ItemId = if_abap_behv=>mk-on )
          TO reported-orderitems.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD validateQty.
    READ ENTITIES OF zpla_i_order IN LOCAL MODE
      ENTITY Orderitems
        FIELDS ( CartQty OrderUuid ) WITH CORRESPONDING #( keys )
      RESULT DATA(orderitems).

    DATA quantities TYPE SORTED TABLE OF zpla_d_orderitem WITH UNIQUE KEY orderitem_uuid.

    quantities = CORRESPONDING #( orderitems DISCARDING DUPLICATES MAPPING orderitem_uuid = OrderitemUuid EXCEPT * ).
    DELETE quantities WHERE cart_qty IS INITIAL.

    LOOP AT orderitems ASSIGNING FIELD-SYMBOL(<ls_orderitem>).
      IF <ls_orderitem>-CartQty < 1.
        APPEND VALUE #(  %tky = <ls_orderitem>-%tky ) TO failed-orderitems.

        APPEND VALUE #(  %tky        = <ls_orderitem>-%tky
                         %state_area = 'VALIDATE_QUANTITY'
                         %path       = VALUE #( Order-%is_draft = <ls_orderitem>-%is_draft
                                                Order-OrderUuid = <ls_orderitem>-OrderUuid )
                         %msg        = NEW zcm_pla_project3(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_pla_project3=>zero_quantity
                                           cartqty    = <ls_orderitem>-CartQty
                                            )
                         %element-CartQty = if_abap_behv=>mk-on )
          TO reported-orderitems.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
