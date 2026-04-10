import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Términos y condiciones'),
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back,
              color: Colors.white
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        // backgroundColor: context.cardColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            RichText(
              text: const TextSpan(
                  text: '1.   PROPIETARIO DE LA MARCA MIXIMIKE, WWW.MIXIMIKE.COM Y LA APP MIXIMIKE',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
            const SizedBox(height: 2),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'El propietario de las marcas, dominio web y software de la aplicación móvil es',
                        style: TextStyle(color: Colors.black)
                    ),
                    TextSpan(
                        text: ' Producciones y Música SpA (PROMUS SpA) ',
                        style: TextStyle(color: Colors.black)
                    ),
                    TextSpan(
                        text: ', sociedad por acciones chilena, con sede en Santiago de Chile y cuyo Rol Único Tributario es 77.806.206-2',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),

            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                  text: '2.   ACEPTACIÓN DE LOS TÉRMINOS Y CONDICIONES',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
            const SizedBox(height: 2),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Al utilizar nuestro servicio, declaras ser mayor de edad y tener capacidad legal para aceptar estos Términos y Condiciones. '
                            'Si no estás de acuerdo con alguna parte de estos Términos y Condiciones, te solicitamos que no utilices nuestro servicio.',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),

            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                  text: '3.   DESCRIPCIÓN DEL SERVICIO',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
            const SizedBox(height: 2),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Nuestro Sitio Web/App es un servicio de streaming de contenido infantil en formato audio y audiovisual, '
                            'que te permite acceder, adquirir, descargar y reproducir el contenido desde la APP.',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),

            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                  text: '4.   REGISTRO DE CUENTA',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
            const SizedBox(height: 2),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Para utilizar nuestro servicio, deberás comprar el contenido que desees, crear una cuenta de usuario y descargar e instalar la App en tu(s) '
                            'dispositivo(s) móvil(es) para guardarlo y reproducirlo cuando gustes. Deberás proporcionar información precisa y completa al registrarte, '
                            'y te comprometes a mantener la confidencialidad de tu cuenta y contraseña. Eres responsable de todas las actividades realizadas en tu cuenta.',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),

            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                  text: '5.   DERECHOS DE PROPIEDAD INTELECTUAL',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
            const SizedBox(height: 2),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Todos los derechos de propiedad intelectual relacionados con nuestro servicio y contenidos, incluyendo, '
                            'pero no limitados a la música y cuentos infantiles, las marcas registradas, los logotipos y el software, son propiedad exclusiva de ',
                        style: TextStyle(color: Colors.black)
                    ),
                    TextSpan(
                        text: ' PROMUS SpA ',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                        text: 'y/o de los titulares de los derechos correspondientes. No se concede ningún derecho '
                            'de propiedad intelectual al usuario, excepto para el uso personal y no comercial del servicio.',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),

            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                  text: '6.   USO PERMITIDO Y RESTRICCIONES',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
            const SizedBox(height: 2),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'El uso de nuestro servicio está sujeto a las siguientes restricciones:',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'a) No puedes utilizar nuestro servicio de manera que infrinja las leyes aplicables o viole los derechos de terceros.',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'b) No puedes copiar, reproducir, distribuir, transmitir, exhibir públicamente, vender, alquilar, '
                            'arrendar ni realizar trabajos derivados basados en nuestro servicio o en su contenido sin la autorización previa por escrito de PROMUS SpA.',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'c) No puedes eludir o desactivar cualquier medida de protección de derechos de autor, ni utilizar técnicas de ingeniería inversa o descompilar el software asociado al servicio.',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),

            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                  text: '7.   PRIVACIDAD',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
            const SizedBox(height: 2),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Respetamos tu privacidad y tratamos tus datos personales de acuerdo con nuestra Política de Privacidad. '
                            'Al utilizar nuestro servicio, aceptas nuestro uso de tus datos personales de acuerdo con dicha política.',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),

            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                  text: '8.   LIMITACIÓN DE RESPONSABILIDAD',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
            const SizedBox(height: 2),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Nos esforzamos por proporcionar siempre un servicio seguro y confiable. No obstante, '
                            'en la medida máxima permitida por la ley aplicable, ',
                        style: TextStyle(color: Colors.black)
                    ),
                    TextSpan(
                        text: ' PROMUS SpA ',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                        text: 'no será responsable de ningún daño directo, indirecto, incidental, '
                            'especial o consecuente derivado del uso o la imposibilidad de uso de nuestro servicio. ',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Nos reservamos el derecho de suspender, modificar o interrumpir '
                            'el Sitio Web/App en cualquier momento sin previo aviso.',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),

            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                  text: '9.   MODIFICACIONES DE LOS TÉRMINOS Y CONDICIONES',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
            const SizedBox(height: 2),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Nos reservamos el derecho de modificar o actualizar estos Términos y Condiciones en cualquier momento. '
                            'Te recomendamos que revises periódicamente los Términos y Condiciones para estar informado de cualquier cambio.'
                            ' El uso continuado de nuestro servicio después de dichas modificaciones constituirá tu aceptación de los nuevos términos.',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Si el usuario no cumple con estos términos, el propietario puede rescindir el acceso al servicio sin previo aviso.',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Al utilizar nuestro Sitio Web/App, confirmas que has leído, entendido y aceptado estos Términos y Condiciones. Si no estás de acuerdo con alguno de estos términos, te pedimos que no utilices nuestro servicio.',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),

            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                  text: '10.   CONTACTO',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
            const SizedBox(height: 2),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Si tienes alguna pregunta o inquietud sobre estos Términos y Condiciones, '
                            'no dudes en ponerte en contacto con nosotros a través de los canales de contacto proporcionados en el Sitio Web/App.',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),

            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                  text: '11.   FECHA DE ENTRADA EN VIGENCIA DE LOS TÉRMINOS Y CONDICIONES',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
            const SizedBox(height: 2),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'A partir del 01 de enero de 2024.',
                        style: TextStyle(color: Colors.black)
                    ),
                  ]
              ),
            ),

          ],
        ).paddingAll(20),
      ),
    );
  }
}
