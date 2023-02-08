@AbapCatalog.sqlViewName: 'ZPLAB_STATUS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for status'
@ObjectModel.resultSet.sizeCategory: #XS

define view zpla_b_status
  as select from zpla_d_status as Status

  association [0..1] to I_Language as _Language on $projection.Langu = _Language.Language

{
  key langu              as Langu,
  @ObjectModel.text.element: ['StatusDescription']
  key status_id          as StatusId,
      status_description as StatusDescription,

      _Language
}
