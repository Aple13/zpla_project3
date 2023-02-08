@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for Customer'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zpla_b_customer
  as select from zpla_d_customer as Customer
{
key   customer_id           as CustomerId,
      customer_first_name   as CustomerFirstName,
      customer_last_name    as CustomerLastName,
      customer_phone_number as CustomerPhoneNumber,
      customer_email        as CustomerEmail,
      address_id            as AddressId,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
