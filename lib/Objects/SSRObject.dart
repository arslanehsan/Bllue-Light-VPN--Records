class SSRObject {
  String? address, port, password, remarks, id;

  SSRObject({
    this.address,
    this.port,
    this.password,
    this.remarks,
    this.id,
  });

  factory SSRObject.fromString({required String stringData}) {
    print('SSR DATA GETTING $stringData');

    List<String> data = stringData.split('-sd-');

    return SSRObject(
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

  List<String> ssrObjectListToStringList({required List<SSRObject> listData}) {
    List<String> stringListData = [];

    for (var element in listData) {
      stringListData.add(
        element.toStringConvert(),
      );
    }
    return stringListData;
  }
}
