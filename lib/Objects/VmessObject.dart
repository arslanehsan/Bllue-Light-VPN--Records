class VMESSObject {
  String? address, port, userId, path, tls, type, version, remarks, id;

  VMESSObject({
    this.address,
    this.port,
    this.userId,
    this.path,
    this.tls,
    this.type,
    this.version,
    this.remarks,
    this.id,
  });

  factory VMESSObject.fromString({
    required String stringData,
  }) {
    print('VMESS DATA GETTING $stringData');

    List<String> data = stringData.split('-sd-');

    return VMESSObject(
      id: data[0],
      address: data[1],
      port: data[2],
      userId: data[3],
      path: data[4],
      tls: data[5],
      type: data[6],
      version: data[7],
      remarks: data[8],
    );
  }

  String toStringConvert() {
    final String data =
        '$id-sd-$address-sd-$port-sd-$userId-sd-$path-sd-$tls-sd-$type-sd-$version-sd-$remarks';

    return data;
  }

  List<String> vmessObjectListToStringList(
      {required List<VMESSObject> listData}) {
    List<String> stringListData = [];

    for (var element in listData) {
      stringListData.add(
        element.toStringConvert(),
      );
    }
    return stringListData;
  }
}
