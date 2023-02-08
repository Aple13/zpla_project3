@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for delivery type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity zpla_b_delivery_type
  as select from zpla_d_deliv_typ

  association to I_Currency as _Currency on $projection.Currency = _Currency.Currency

{
      @ObjectModel.text.element: ['DeliveryName']
  key type_id       as TypeId,
      delivery_name as DeliveryName,
      @Semantics.amount.currencyCode: 'Currency'
      delivery_cost as DeliveryCost,
      currency      as Currency,

      _Currency
}
