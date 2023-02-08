CLASS lhc_Order DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF order_status,
        new         TYPE c LENGTH 1  VALUE '1',
        in_progress TYPE c LENGTH 1  VALUE '2',
        completed   TYPE c LENGTH 1  VALUE '3',
        canceled    TYPE c LENGTH 1  VALUE '4',
      END OF order_status.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Order RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Order RESULT result.

    METHODS setOrderId FOR DETERMINE ON SAVE
      IMPORTING keys FOR Order~setOrderId.

    METHODS recalctotalprice FOR MODIFY
      IMPORTING keys FOR ACTION order~recalcTotalPrice.

    METHODS calculateTotalPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Order~calculateTotalPrice.

    METHODS progressStatus FOR MODIFY
      IMPORTING keys FOR ACTION Order~progressStatus RESULT result.

    METHODS completedStatus FOR MODIFY
      IMPORTING keys FOR ACTION Order~completedStatus RESULT result.

    METHODS canceledStatus FOR MODIFY
      IMPORTING keys FOR ACTION Order~canceledStatus RESULT result.

    METHODS validatecustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR order~validatecustomer.

    METHODS validatedelivery FOR VALIDATE ON SAVE
      IMPORTING keys FOR order~validatedelivery.


ENDCLASS.

CLASS lhc_Order IMPLEMENTATION.

    METHOD get_instance_features.
    READ ENTITIES OF zpla_i_order IN LOCAL MODE
      ENTITY Order
        FIELDS ( StatusId ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders)
      FAILED failed.

    result =
      VALUE #(
        FOR order IN orders
          LET is_in_progress   =   COND #( WHEN order-StatusId = order_status-in_progress
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled )
              is_completed  =   COND #( WHEN order-StatusId = order_status-completed
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled  )
              is_canceled =   COND #( WHEN order-StatusId = order_status-canceled
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled )
          IN
            ( %tky                    = order-%tky
              %action-progressStatus  = is_in_progress
              %action-completedStatus = is_completed
              %action-canceledStatus  = is_canceled
             ) ).

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD setorderid.
    READ ENTITIES OF zpla_i_order IN LOCAL MODE
      ENTITY Order
        FIELDS ( OrderId OrderDate ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    DELETE orders WHERE OrderId IS NOT INITIAL.

    CHECK orders IS NOT INITIAL.

    SELECT SINGLE
        FROM  zpla_d_order
        FIELDS MAX( order_id ) AS OrderId
        INTO @DATA(max_orderid).

    DATA date TYPE zpla_order_date.
    date = sy-datum.

    MODIFY ENTITIES OF zpla_i_order IN LOCAL MODE
    ENTITY Order
      UPDATE
        FROM VALUE #( FOR order IN orders INDEX INTO i (
          %tky             = order-%tky
          OrderId          = max_orderid + i
          OrderDate        = date
          StatusId         = '1'
          %control-OrderId = if_abap_behv=>mk-on
          %control-OrderDate = if_abap_behv=>mk-on
          %control-StatusId = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD calculatetotalprice.
    MODIFY ENTITIES OF zpla_i_order IN LOCAL MODE
      ENTITY order
        EXECUTE recalcTotalPrice
        FROM CORRESPONDING #( keys )
      REPORTED DATA(execute_reported).

    reported = CORRESPONDING #( DEEP execute_reported ).
  ENDMETHOD.

  METHOD recalctotalprice.
    TYPES: BEGIN OF ty_amount_per_currencycode,
             amount        TYPE /dmo/total_price,
             currency_code TYPE /dmo/currency_code,
           END OF ty_amount_per_currencycode.

    DATA: amount_per_currencycode TYPE STANDARD TABLE OF ty_amount_per_currencycode.
    DATA: tt_cart TYPE TABLE FOR UPDATE zpla_i_order\\OrderItems.

    READ ENTITIES OF zpla_i_order IN LOCAL MODE
         ENTITY Order
            FIELDS ( DeliveryId )
            WITH CORRESPONDING #( keys )
         RESULT DATA(orders).

    DELETE orders WHERE DeliveryId IS INITIAL.

    LOOP AT orders ASSIGNING FIELD-SYMBOL(<order>).

      SELECT SINGLE DeliveryCost, Currency
          FROM zpla_b_delivery_type AS Delivery
          WHERE Delivery~TypeId = @<order>-DeliveryId
              INTO @DATA(ls_del_cost).

      amount_per_currencycode = VALUE #( ( amount        = ls_del_cost-DeliveryCost
                                           currency_code = ls_del_cost-Currency ) ).

      READ ENTITIES OF zpla_i_order IN LOCAL MODE
        ENTITY Order BY \_OrderItems
          FIELDS ( ItemId CartQty )
        WITH VALUE #( ( %tky = <order>-%tky ) )
        RESULT DATA(OrderItems).

      LOOP AT OrderItems ASSIGNING FIELD-SYMBOL(<Items>).
        SELECT SINGLE ItemPrice
            FROM zpla_b_item
            WHERE zpla_b_item~ItemId = @<Items>-ItemId
                INTO @DATA(lv_price).
        <Items>-CartSubtotal = lv_price * <Items>-CartQty.

        SELECT SINGLE Currency
            FROM zpla_b_item
            WHERE zpla_b_item~ItemId = @<Items>-ItemId
                INTO @DATA(lv_curr).
        <Items>-Currency = lv_curr.

        APPEND VALUE #(
                amount = <Items>-CartSubtotal
                currency_code = <Items>-Currency
                      ) TO amount_per_currencycode.

        APPEND VALUE #(
                %tky         = <Items>-%tky
                ItemID       = <Items>-ItemId
                CartSubtotal = <Items>-CartSubtotal
                Currency     = <Items>-Currency
                %control-ItemID = if_abap_behv=>mk-on
                %control-CartSubtotal = if_abap_behv=>mk-on
                %control-Currency = if_abap_behv=>mk-on
                       ) TO tt_cart.

      ENDLOOP.

      MODIFY ENTITIES OF zpla_i_order IN LOCAL MODE
                ENTITY OrderItems
                  UPDATE FIELDS ( CartSubtotal Currency ) WITH tt_cart.

      CLEAR <order>-OrderTotalCost.

      LOOP AT amount_per_currencycode INTO DATA(single_amount).
        <order>-OrderTotalCost += single_amount-amount.
        <order>-Currency = single_amount-currency_code.
      ENDLOOP.

    ENDLOOP.

    MODIFY ENTITIES OF zpla_i_order IN LOCAL MODE
      ENTITY order
        UPDATE FIELDS ( OrderTotalCost Currency )
        WITH CORRESPONDING #( orders ).

  ENDMETHOD.

  METHOD canceledstatus.
    MODIFY ENTITIES OF zpla_i_order IN LOCAL MODE
      ENTITY Order
         UPDATE
           FIELDS ( StatusId )
           WITH VALUE #( FOR key IN keys
                           ( %tky         = key-%tky
                             StatusId = order_status-canceled ) )
      FAILED failed
      REPORTED reported.

    READ ENTITIES OF zpla_i_order IN LOCAL MODE
      ENTITY Order
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    result = VALUE #( FOR order IN orders
                        ( %tky   = order-%tky
                          %param = order ) ).
  ENDMETHOD.

  METHOD completedstatus.
    MODIFY ENTITIES OF zpla_i_order IN LOCAL MODE
      ENTITY Order
         UPDATE
           FIELDS ( StatusId )
           WITH VALUE #( FOR key IN keys
                           ( %tky         = key-%tky
                             StatusId = order_status-completed ) )
      FAILED failed
      REPORTED reported.

    READ ENTITIES OF zpla_i_order IN LOCAL MODE
      ENTITY Order
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    result = VALUE #( FOR order IN orders
                        ( %tky   = order-%tky
                          %param = order ) ).
  ENDMETHOD.

  METHOD progressstatus.
    MODIFY ENTITIES OF zpla_i_order IN LOCAL MODE
      ENTITY Order
         UPDATE
           FIELDS ( StatusId )
           WITH VALUE #( FOR key IN keys
                           ( %tky         = key-%tky
                             StatusId = order_status-in_progress ) )
      FAILED failed
      REPORTED reported.

    READ ENTITIES OF zpla_i_order IN LOCAL MODE
      ENTITY Order
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    result = VALUE #( FOR order IN orders
                        ( %tky   = order-%tky
                          %param = order ) ).
  ENDMETHOD.

  METHOD validatecustomer.
    READ ENTITIES OF zpla_i_order IN LOCAL MODE
      ENTITY Order
        FIELDS ( CustomerId ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    DATA customers TYPE SORTED TABLE OF zpla_d_customer WITH UNIQUE KEY customer_id.

    customers = CORRESPONDING #( orders DISCARDING DUPLICATES MAPPING customer_id = CustomerId EXCEPT * ).
    DELETE customers WHERE customer_id IS INITIAL.

    IF customers IS NOT INITIAL.
      SELECT FROM zpla_d_customer FIELDS customer_id
        FOR ALL ENTRIES IN @customers
        WHERE customer_id = @customers-customer_id
        INTO TABLE @DATA(customers_db).
    ENDIF.

    LOOP AT orders INTO DATA(order).
      IF order-CustomerId IS INITIAL OR NOT line_exists( customers_db[ customer_id = order-CustomerId ] ).
        APPEND VALUE #(  %tky = order-%tky ) TO failed-order.

        APPEND VALUE #(  %tky        = order-%tky
                         %state_area = 'VALIDATE_CUSTOMER'
                         %msg        = NEW zcm_pla_project3(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_pla_project3=>customer_unknown
                                           customerid = order-CustomerId )
                         %element-CustomerId = if_abap_behv=>mk-on )
          TO reported-order.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDelivery.
    READ ENTITIES OF zpla_i_order IN LOCAL MODE
      ENTITY Order
        FIELDS ( DeliveryId ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    DATA deliveries TYPE SORTED TABLE OF zpla_d_deliv_typ WITH UNIQUE KEY type_id.

    deliveries = CORRESPONDING #( orders DISCARDING DUPLICATES MAPPING type_id = DeliveryId EXCEPT * ).
    DELETE deliveries WHERE type_id IS INITIAL.

    IF deliveries IS NOT INITIAL.
     SELECT FROM zpla_d_deliv_typ FIELDS type_id
        FOR ALL ENTRIES IN @deliveries
        WHERE type_id = @deliveries-type_id
        INTO TABLE @DATA(deliveries_db).
    ENDIF.

    LOOP AT orders INTO DATA(order).
      IF order-DeliveryId IS INITIAL OR NOT line_exists( deliveries_db[ type_id = order-DeliveryId ] ).
        APPEND VALUE #(  %tky = order-%tky ) TO failed-order.

        APPEND VALUE #(  %tky        = order-%tky
                         %state_area = 'VALIDATE_DELIVERY'
                         %msg        = NEW zcm_pla_project3(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_pla_project3=>delivery_unknown
                                           deliveryid = order-DeliveryId )
                         %element-DeliveryId = if_abap_behv=>mk-on )
          TO reported-order.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
