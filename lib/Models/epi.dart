class Epi {
  final int id;
  final String nome;
  final String instrucaoUso;

  Epi({required this.id, required this.nome, required this.instrucaoUso});

  factory Epi.fromJson(Map<String, dynamic> json) {
    return Epi(
        id: json['idEpi'],
        nome: json['nomeEpi'], 
        instrucaoUso: json['insUso']);
  }
}
