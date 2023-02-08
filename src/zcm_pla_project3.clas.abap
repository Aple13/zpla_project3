CLASS zcm_pla_project3 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF customer_unknown,
        msgid TYPE symsgid VALUE 'ZPLA_MSG_PROJECT3',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'CUSTOMERID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF customer_unknown ,

      BEGIN OF delivery_unknown,
        msgid TYPE symsgid VALUE 'ZPLA_MSG_PROJECT3',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF delivery_unknown ,

      BEGIN OF item_unknown,
        msgid TYPE symsgid VALUE 'ZPLA_MSG_PROJECT3',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'ITEMID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF item_unknown ,

      BEGIN OF zero_quantity,
        msgid TYPE symsgid VALUE 'ZPLA_MSG_PROJECT3',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'CARTQTY',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF zero_quantity.

    METHODS constructor
      IMPORTING
        severity   TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        textid     LIKE if_t100_message=>t100key OPTIONAL
        previous   TYPE REF TO cx_root   OPTIONAL
        customerid TYPE zpla_customer_id OPTIONAL
        deliveryid TYPE zpla_delivery_id OPTIONAL
        itemid     TYPE zpla_item_id     OPTIONAL
        cartqty    TYPE zpla_item_qty    OPTIONAL.

    DATA customerid TYPE zpla_customer_id READ-ONLY.
    DATA deliveryid TYPE zpla_delivery_id READ-ONLY.
    DATA itemid     TYPE zpla_item_id     READ-ONLY.
    DATA cartqty    TYPE zpla_item_qty    READ-ONLY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcm_pla_project3 IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.

    me->if_abap_behv_message~m_severity = severity.
    me->customerid = customerid.
    me->deliveryid = deliveryid.
    me->itemid     = itemid.
    me->cartqty    = cartqty.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
