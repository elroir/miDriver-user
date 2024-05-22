class TransportType{

  final int id;
  final String name;
  final String imageUrl;
  final bool defaultTransportType;

  const TransportType({required this.id, required this.name, required this.imageUrl,this.defaultTransportType = false});

  const TransportType.car() : id = 1, name = 'Auto', imageUrl = '', defaultTransportType = true;

  const TransportType.motorcycle() : id = 2, name = 'Moto', imageUrl = '' , defaultTransportType = false;

}