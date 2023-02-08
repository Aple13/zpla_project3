@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS for Order'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define root view entity zpla_i_order
  as select from zpla_b_order

  composition [1..*] of zpla_i_order_items as _OrderItems

  association [1] to zpla_i_customer       as _Customer on $projection.CustomerId = _Customer.CustomerId
  association [1] to zpla_b_status         as _Status   on $projection.StatusId   = _Status.StatusId
  association [1] to zpla_b_delivery_type  as _Delivery on $projection.DeliveryId = _Delivery.TypeId

{
  key OrderUuid,
      OrderId,
      CustomerId,
      concat_with_space( _Customer.CustomerFirstName, _Customer.CustomerLastName, 1) as FullName,
      OrderDate,
      dats_add_days( OrderDate, 3, 'INITIAL' ) as DeliveryDate,
      DeliveryId,
      StatusId,
      case StatusId
        when '000001'  then 2    -- 'new'         | 2: yellow colour
        when '000002'  then 0    -- 'in progress' | 3: green colour
        when '000003'  then 3    -- 'completed'   | 1: red colour
            else 1               -- 'canceled'    | 0: unknown
      end                                      as StatusCriticality,

      @Semantics.amount.currencyCode: 'Currency'
      _Delivery.DeliveryCost                   as DeliveryCost,
      @Semantics.amount.currencyCode: 'Currency'
      OrderTotalCost,
      Currency,
      @Semantics.user.createdBy: true
      CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      CreatedAt,
      @Semantics.user.createdBy: true
      LastChangedBy,
      @Semantics.systemDateTime.createdAt: true
      LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,

      _OrderItems,
      _Customer,
      _Delivery,
      _Status
}
