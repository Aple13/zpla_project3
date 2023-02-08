@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for Order Analysis'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zpla_b_order_analysis
  as select from zpla_d_order
{
  key order_uuid            as OrderUuid,
      order_id              as OrderId,
      customer_id           as CustomerId,
      order_date            as OrderDate,
      delivery_id           as DeliveryId,
      status_id             as StatusId,
      @Semantics.amount.currencyCode: 'Currency'
      order_total_cost      as OrderTotalCost,
      currency              as Currency,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.createdBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.createdAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
