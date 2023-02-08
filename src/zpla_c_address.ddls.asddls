@EndUserText.label: 'Consumption CDS for Address'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity zpla_c_address
  as projection on zpla_i_address as Address
  
{     
  key AddressId,
  @Search.defaultSearchElement: true
      CustomerId,
      Postcode,
      City,
      Street,
      Building,
      Apartments,
      LastChangedAt,
      LocalLastChangedAt,
      
      _Customer : redirected to parent zpla_c_customer  
}
