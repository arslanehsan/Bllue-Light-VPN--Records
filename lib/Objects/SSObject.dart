class SSObject {
  String? address, port, password, remarks, id;

  SSObject({
    this.address,
    this.port,
    this.password,
    this.remarks,
    this.id,
  });

  factory SSObject.fromString({required String stringData}) {
    print('SS DATA GETTING $stringData');

    List<String> data = stringData.split('-sd-');

    return SSObject(
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

  List<String> ssObjectListToStringList({required List<SSObject> listData}) {
    List<String> stringListData = [];

    for (var element in listData) {
      stringListData.add(
        element.toStringConvert(),
      );
    }
    return stringListData;
  }
}
