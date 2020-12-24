class Municipio {
  final int id_municipio;
  final String nome;

  const Municipio({
    this.id_municipio,
    this.nome,
  });
}

class Area {
  final int id_area;
  final int id_municipio;
  final String codigo;

  const Area({
    this.id_area,
    this.id_municipio,
    this.codigo,
  });
}

class Censitario {
  final int id_censitario;
  final int id_area;
  final String codigo;

  const Censitario({
    this.id_censitario,
    this.id_area,
    this.codigo,
  });
}

class Quarteirao {
  final int id_quarteirao;
  final int id_censitario;
  final String numero;
  final String sub_numero;
  const Quarteirao({
    this.id_quarteirao,
    this.id_censitario,
    this.numero,
    this.sub_numero,
  });
}

class Imovel {
  final int id_imovel;
  final int id_municipio;
  final int id_quarteirao;
  final String numero_imovel;
  final String endereco;
  final int id_atividade;

  const Imovel({
    this.id_imovel,
    this.id_municipio,
    this.id_quarteirao,
    this.numero_imovel,
    this.endereco,
    this.id_atividade,
  });
}

class GrupoRec {
  final int id_grupo_rec;
  final String codigo;
  final String nome;

  const GrupoRec({
    this.id_grupo_rec,
    this.codigo,
    this.nome,
  });
}

class TipoRec {
  final int id_tipo_rec;
  final int id_grupo_rec;
  final String nome;

  const TipoRec({
    this.id_tipo_rec,
    this.id_grupo_rec,
    this.nome,
  });
}

class Atividade {
  final int id_atividade;
  final String nome;
  final int grupo;

  const Atividade({
    this.id_atividade,
    this.nome,
    this.grupo,
  });
}
