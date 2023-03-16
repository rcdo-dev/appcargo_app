import 'package:app_cargo/domain/omni/new_proposal_requrest/simulation.dart';
import 'package:app_cargo/http/transformers.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class RequestNewRefinancingController {
  MaskedTextController itin;
  MaskedTextController birthDate;
  MaskedTextController phone;
  MaskedTextController zipCode;
  MaskedTextController licensePlate;
  MoneyMaskedTextController monthlyIncome;
  String uf;

  RequestNewRefinancingController() {
    itin = new MaskedTextController(mask: '000.000.000-00', text: '');
    birthDate = new MaskedTextController(mask: '00/00/0000', text: '');

    phone = new MaskedTextController(mask: '(00) 0000-0000', text: '');
    phone.beforeChange = handlePhoneBeforeChange;

    zipCode = new MaskedTextController(mask: '00000-000', text: '07844-220');
    licensePlate = new MaskedTextController(mask: 'AAA0@00', text: '');
    monthlyIncome = new MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.');
    uf = 'AC';
  }

  bool handlePhoneBeforeChange(String beforeChange, String afterChange) {
    print(afterChange.length);

    if (afterChange.length < 15) {
      phone.updateMask('(00) 0000-0000');
      return true;
    } else if (afterChange.length == 15) {
      phone.updateMask('(00) 00000-0000');
      return true;
    }

    return false;
  }

  Simulation getSimulation() {
    Simulation simulation = new Simulation();
    simulation.itin = this.itin.text;
    simulation.birthDate =
        dateFromJson(this.birthDate.text).toString().split(' ')[0];
    simulation.phone = this.phone.text.replaceAll(' ', '');
    simulation.zipCode = this.zipCode.text;
    simulation.licensePlate = this.licensePlate.text;
    simulation.uf = this.uf;
    simulation.monthlyIncome = double.parse(
        this.monthlyIncome.text.replaceAll('.', '').replaceAll(',', '.'));
    return simulation;
  }

  String validate() {
    if (this.itin.text.trim().isEmpty ||
        this.birthDate.text.trim().isEmpty ||
        this.zipCode.text.trim().isEmpty ||
        this.licensePlate.text.trim().isEmpty ||
        this.phone.text.trim().isEmpty ||
        this.monthlyIncome.text.trim().isEmpty ||
        this.uf.isEmpty) {
      return "Preencha todos os campos";
    }

    if (this.birthDate.text.trim().length != 10) {
      return "Digite uma data válida!";
    }

    if (checkInvalidDriverAge(this.birthDate.text.trim())) {
      return "Insira uma data de nascimento válida!";
    }

    if (this.itin.text.trim().length != 14) {
      return "Digite um CPF válido!";
    }
    if (this.phone.text.trim().length != 15) {
      if (this.phone.text.trim().length != 14) {
        return "Digite um número de telefone válido!";
      }
    }
    if (this.zipCode.text.trim().length != 9) {
      return "Digite um CEP válido!";
    }
    if (this.licensePlate.text.trim().length != 7) {
      return "Digite uma placa de veículo válida!";
    }

    if (convertStringToDouble(this.monthlyIncome.text.trim()) == 0) {
      return "Informe uma renda mensal diferente de R\$0,00";
    }

    if (convertStringToDouble(this.monthlyIncome.text.trim()) < 100) {
      return "Informe uma renda mensal maior que R\$100,00";
    }

    return "";
  }

  fillFieldsForTest() {
    this.itin.text = "093.872.678-14";
    this.birthDate.text = "21/10/1981";
    this.phone.text = "(11)93100-9996";
    this.zipCode.text = "08710-040";
    this.uf = "SP";
    this.licensePlate.text = "FEN3440";
    this.monthlyIncome.text = "6.000,00";
  }
}
