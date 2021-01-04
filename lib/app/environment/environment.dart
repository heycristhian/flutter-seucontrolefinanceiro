class Environment {
  final String urlApi = 'http://ec2-3-138-112-143.us-east-2.compute.amazonaws.com:8080';
  // final String urlApi = 'http://172.18.0.1:8080';
  // final String urlApi = 'http://172.17.196.49:8080';
  String api({String endpoint}) {
    return this.urlApi + '/' + endpoint;
  }
}
