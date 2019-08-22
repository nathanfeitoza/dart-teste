import 'dart:core';
import 'dart:io';

class Forca 
{
  static String _palavra;
  static List<String> _letras = [];
  static int _letrasValidadas = 0;
  static const _ocultadorLetras = '*'; 

  Forca(String palavra) 
  {
    _palavra = palavra;
    for(var i in this.getLetrasPalavras()) {
      _letras.add(_ocultadorLetras);
    }
  }

  List<String> getLetrasPalavras()
  {
    return _palavra.split('');
  }

  int getQuantidadeLetras()
  {
    return this.getLetrasPalavras().length;
  }

  bool validarPalavra(String palavraEnviada)
  {
    
    return palavraEnviada == _palavra;
  }

  bool setLetra(String letra) 
  {
      List<String> palavraArray = this.getLetrasPalavras();
      int indexLetra = palavraArray.indexOf(letra);
      if(indexLetra != -1) {
        
        if(_letras.indexOf(letra) != -1) {
          return true;
        }

        for (var i = 0; i < this.getQuantidadeLetras(); i++) {
          if(palavraArray[i].toLowerCase() == letra.toLowerCase()) {
            _letras[i] = letra.toLowerCase();
            _letrasValidadas++;
          }
        }
        return true;
      }

      return false;
  }

  String getPalavraMontadaComLetrasEnviadas()
  {
    return _letras.join(' ');
  }

  int getLetrasValidadas()
  {
    return _letrasValidadas;
  }

}

void main() {
  int terminarJogo = 0;
  int tentativas = 5;
  const mensagemVitoria = 'Você ganhou, parabéns!';
  print('Informe a palavra: ');
  var palavra = stdin.readLineSync();
  Forca forca = new Forca(palavra);

  while(terminarJogo == 0) {
    
    if(tentativas == 0) {
      terminarJogo = -1;
      break;
    }

    print('Digite uma letra ou palvra: ');
    var letraPalavra = stdin.readLineSync();
    bool letraPalavraValidou = palavra == letraPalavra;

    if(letraPalavraValidou) {
      terminarJogo = -1;
      print(mensagemVitoria);
      break;
    }

    if(letraPalavra.length == 1) {
      letraPalavraValidou = forca.setLetra(letraPalavra);
    } 

    if(!letraPalavraValidou) {
      tentativas--;

      String mensagem = tentativas != 0 ? 'A palavra não tem essa letra. Você ainda tem mais $tentativas tentativas' : 'Suas tentativas acabaram que pena... Tente novamente!';

      print(mensagem);
      continue;
    }
    
    if(forca.getLetrasValidadas() == forca.getQuantidadeLetras()) {
      terminarJogo = -1;
      print(mensagemVitoria);
      break;
    }

    print(forca.getPalavraMontadaComLetrasEnviadas());

  }

}