class ImovelVC {
  final int id_imovel;
  final int id_visita;
  int id_situacao;
  int ordem;
  String casa;
  int focal;
  int perifocal;
  int nebulizacao;
  int mecanico;
  int alternativo;
  int qt_focal;
  int qt_peri;
  int qt_neb;
  String latitude;
  String longitude;

  ImovelVC(
    this.id_imovel,
    this.id_visita, {
    this.id_situacao,
    this.ordem,
    this.casa,
    this.focal,
    this.perifocal,
    this.nebulizacao,
    this.mecanico,
    this.alternativo,
    this.qt_focal,
    this.qt_peri,
    this.qt_neb,
    this.latitude,
    this.longitude,
  });
}
