const DUMMY_REGIONAL = {
  '1': const Local(codigo: 1, nome: "DPE"),
	'2': const Local(codigo: 2, nome: "São Vicente"),
	'3': const Local(codigo: 3, nome: "Taubaté"),
	'4': const Local(codigo: 4, nome: "Sorocaba"),
	'5': const Local(codigo: 5, nome: "Campinas"),
	'6': const Local(codigo: 6, nome: "Ribeirão Preto"),
	'8': const Local(codigo: 8, nome: "São José do Rio Preto"),
	'9': const Local(codigo: 9, nome: "Araçatuba"),
	'10': const Local(codigo: 10, nome: "Presidente Prudente"),
	'11': const Local(codigo: 11, nome: "Marília")
};

const DUMMY_DRS = {
  '1': const Local(codigo: 12, nome: 'Registro'),
  '2': const Local(codigo: 243, nome: 'Bauru'),
};

const DUMMY_COLEGIADO = {
  '1': const Local(codigo: 12, nome: 'Vale do Ribeira'),
  '2': const Local(codigo: 243, nome: 'Polo Cuesta'),
};

const DUMMY_MUNICIPIO = {
  '1': const Local(codigo: 12, nome: 'São Paulo'),
  '2': const Local(codigo: 243, nome: 'Guarulhos'),
  '3': const Local(codigo: 645, nome: 'Piquete'),
};

class Local {
  final int codigo;
  final String nome;

  const Local({this.codigo, this.nome});
}
