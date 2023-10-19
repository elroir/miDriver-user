class TransportType{

  final int id;
  final String name;
  final String imageUrl;

  const TransportType({required this.id, required this.name, required this.imageUrl});

  const TransportType.car() : id = 1, name = 'Auto', imageUrl = '';

}