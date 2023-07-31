class TrojanObject {
  String? password, remarks, address, port, id;

  TrojanObject({
    this.address,
    this.port,
    this.password,
    this.remarks,
    this.id,
  });

  factory TrojanObject.fromString({
    required String stringData,
  }) {
    print('Trojan DATA GETTING $stringData');

    List<String> data = stringData.split('-sd-');

    return TrojanObject(
      id: data[0],
      address: data[1],
      port: data[2],
      password: data[3],
      remarks: data[4],
    );
  }

  String toStringConvert() {
    final String data = '$id-sd-$address-sd-$port-sd-$password-sd-$remarks';

    return data;
  }

  List<String> trojanObjectListToStringList(
      {required List<TrojanObject> listData}) {
    List<String> stringListData = [];

    for (var element in listData) {
      stringListData.add(
        element.toStringConvert(),
      );
    }
    return stringListData;
  }
}
