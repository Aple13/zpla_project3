@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS for Address'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zpla_i_address
  as select from zpla_b_address as Address
  
  association to parent zpla_i_customer as _Customer on $projection.CustomerId = _Customer.CustomerId

{
  key AddressId,
      CustomerId,
      Postcode,
      City,
      Street,
      Building,
      Apartments,
      @Semantics.systemDateTime.createdAt: true
      LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      
      _Customer
}
