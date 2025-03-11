import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});



  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados!';

  void _resetFields(){
    setState(() {
      _infoText = 'Informe seus dados!';
      _formKey = GlobalKey<FormState>();
    })
    ;weightController.text = '';
    heightController.text = '';

  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if(imc < 18.6){
        _infoText = 'Abaixo do Peso (${imc.toStringAsPrecision(3)})';
      } else if(imc >= 18.6 && imc < 24.9){
        _infoText = 'Peso ideal(${imc.toStringAsPrecision(3)}';
      }
      else if(imc >= 24.9 && imc < 29.9){
        _infoText = 'Levemente acima do peso (${imc.toStringAsPrecision(3)})';
      }
      else if(imc >= 29.9 && imc < 34.9){
        _infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(3)})';
      }
      else if(imc >= 34.9 && imc < 39.9){
        _infoText = 'Obesidade Grau II (${imc.toStringAsPrecision(3)})';
      }
      else if(imc >= 40){
        _infoText = 'Obesidade Grau III (${imc.toStringAsPrecision(3)})';
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        titleTextStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(onPressed: _resetFields,
              icon: Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_outline, size: 120, color: Colors.green),
                SizedBox(height: 20),
                TextFormField(keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                      labelText: 'Peso (Kg)',
                      labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 20)
                  ),
                  textAlign: TextAlign.center,
                  controller: weightController,
                  validator: (value){
                    if(value!.isEmpty){
                      return('Insira seu peso');
                    }
                  },
                ),
                TextFormField(keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                      labelText: 'Altura (Cm)',
                      labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 20)
                  ),
                  textAlign: TextAlign.center,
                  controller: heightController,
                  validator: (value){
                    if(value!.isEmpty){
                      return('Insira sua altura');
                    }
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _calculate();
                  }
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text('Calcular', style: TextStyle(color: Colors.white, fontSize: 25),),
                ) ,
                Text(_infoText,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  textAlign: TextAlign.center,)
          
          
          
              ],
            ),
          ),
        ) ,
      )
    );
  }
}
