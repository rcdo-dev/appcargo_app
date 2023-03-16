import 'package:dio/dio.dart';

class HandleClientError{
  static String handleError(DioError receivedError){
    String error = "";
    switch(receivedError.type){
      case DioErrorType.CONNECT_TIMEOUT:
        error = "Tempo limite de conexão com o servidor";
        break;
      case DioErrorType.SEND_TIMEOUT:
        error = "Tempo limite para envio da requisição excedido";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        error = "Tempo limite para receber os dados do servidor excedido";
        break;
      case DioErrorType.RESPONSE:
        error = "Erro inesperado";
        break;
      case DioErrorType.CANCEL:
        error = "Requisição cancelada pelo usuário";
        break;
      case DioErrorType.DEFAULT:
        error = "Erro ao conectar-se com servidor, verifique sua conexão com a internet e tente novamente";
        break;
    }

    return error;

  }
}