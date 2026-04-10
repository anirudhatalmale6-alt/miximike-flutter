import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:get/route_manager.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Politicas de privacidad'),
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
              const SizedBox(height: 10),
              RichText(
                text: const TextSpan(
                    text: '1. RECOPILACIÓN DE LA INFORMACIÓN PERSONAL',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: '1.1 Información proporcionada voluntariamente:',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'Es posible que solicitemos cierta información personal identificable cuando el usuario elige registrarse en nuestro Sitio Web/App, '
                              'realizar una compra, suscribirse a nuestros boletines informativos, participar en encuestas o formularios en línea, o interactuar de'
                              ' cualquier otra manera con nuestros servicios. Esta información puede incluir, entre otros, su nombre, dirección de correo electrónico, '
                              'número de teléfono, dirección postal u otra información relevante necesaria para proporcionar los servicios solicitados. Solo recopilaremos la'
                              ' información necesaria y relevante para cumplir con su solicitud y nunca la compartiremos sin su consentimiento.',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),

              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: '1.2 Cookies y tecnologías similares:',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'Utilizamos cookies y tecnologías similares para recopilar información sobre cómo el '
                              'usuario navega y utiliza nuestro Sitio Web/App. Estas tecnologías nos permiten personalizar '
                              'su experiencia, recordar sus preferencias, rastrear tendencias y mejorar la calidad de nuestros servicios. '
                              'Esta información no está vinculada directamente a su identidad y se utiliza para analizar las tendencias, administrar el'
                              ' sitio, rastrear el movimiento de los usuarios en el sitio y recopilar información demográfica amplia con el '
                              'fin de mejorar la experiencia del usuario.',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'El usuario puede optar por ajustar la configuración de cookies en su navegador para desactivarlas, '
                              'pero debe tener en cuenta que esto puede afectar la funcionalidad y el rendimiento de nuestro Sitio Web/App.',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),


              const SizedBox(height: 10),
              RichText(
                text: const TextSpan(
                    text: '2. USO DE LA INFORMACIÓN PERSONAL',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'La información personal recopilada se utiliza únicamente con los fines específicos para'
                              ' los que fue proporcionada. Esto puede incluir, entre otros, el procesamiento de'
                              ' pedidos, la respuesta a consultas o solicitudes de servicio al cliente, el envío de'
                              ' boletines informativos, la personalización de la experiencia del usuario y la mejora de'
                              ' nuestros servicios y comunicaciones.',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'No utilizaremos la información personal del usuario para ningún propósito no relacionado sin su consentimiento previo.',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'La información personal que recopilamos se utiliza para los siguientes fines:',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'Personalización de la música y otros contenidos infantiles: '
                              'utilizamos la información proporcionada para crear y adaptar contenidos infantiles de '
                              'acuerdo con las preferencias de los usuarios y las de los niños.',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'Comunicación: podemos utilizar su información de contacto para enviarle actualizaciones sobre el Sitio Web/App,'
                              ' novedades musicales y de otros contenidos infantiles, publicidad, promociones u otra información relevante. '
                              'El usuario puede optar por no recibir comunicaciones promocionales en cualquier momento.',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'Mejora del Sitio Web/App: utilizamos la información recopilada'
                              ' para comprender cómo los usuarios interactúan con nuestro Sitio Web/App, con el fin de mejorar su funcionamiento, diseño y contenido.',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),


              const SizedBox(height: 10),
              RichText(
                text: const TextSpan(
                    text: '3. PROTECCIÓN DE LA INFORMACIÓN PERSONAL',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'Implementamos medidas de seguridad apropiadas para proteger '
                              'su información personal contra el acceso no autorizado, la divulgación, la alteración o la destrucción.',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'Nos comprometemos a maximizar la seguridad de su información personal. Sin embargo, el '
                              'usuario debe tener en cuenta que ninguna transmisión de datos a través de Internet o '
                              'método de almacenamiento electrónico es completamente seguro, y no podemos garantizar'
                              ' la seguridad absoluta de su información personal.',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'Divulgación de información a terceros',
                          // underline
                          style: TextStyle(color: Colors.black, decoration: TextDecoration.underline),
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'No vendemos ni compartimos su información personal con terceros sin su consentimiento, excepto en las siguientes circunstancias limitadas:',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: '1. Proveedores de servicios: ',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                      ),TextSpan(
                          text: 'podemos compartir su información con proveedores de servicios externos que nos ayuden a operar el Sitio Web/App '
                              'y a brindarle los servicios solicitados. Estos proveedores están sujetos a acuerdos de '
                              'confidencialidad y solo pueden utilizar su información en la medida necesaria para proporcionar '
                              'los servicios contratados.',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: '2. Cumplimiento legal: ',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                      ),TextSpan(
                          text: 'podemos divulgar su información personal si así lo '
                              'exige la ley o si creemos de buena fe que dicha divulgación es '
                              'necesaria para proteger nuestros derechos, cumplir con un proceso legal o'
                              ' responder a una solicitud gubernamental.',
                          style: TextStyle(color: Colors.black)
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Cambios en la política de privacidad',
                        // underline
                        style: TextStyle(color: Colors.black, decoration: TextDecoration.underline),
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Nos reservamos el derecho de modificar o complementar esta política de privacidad en '
                            'cualquier momento. Cualquier cambio será efectivo cuando se publique la versión revisada en el'
                            ' Sitio Web/App. Le recomendamos que revise periódicamente esta política para '
                            'estar informado sobre cómo protegemos su información personal.',
                        // underline
                        style: TextStyle(color: Colors.black),
                      ),
                    ]
                ),
              ),


              const SizedBox(height: 10),
              RichText(
                text: const TextSpan(
                    text: '4. CONTACTO',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    text: 'Si tiene alguna pregunta o inquietud sobre nuestra Política de Privacidad o el'
                        ' tratamiento de su información personal, no dude en ponerse en contacto '
                        'con nosotros a través de los canales de contacto proporcionados en el Sitio Web/App.',
                    style: TextStyle(color: Colors.black)
                ),
              ),


              const SizedBox(height: 10),
              RichText(
                text: const TextSpan(
                    text: '5. FECHA DE VIGENCIA DE ESTA POLÍTICA DE PRIVACIDAD',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: const TextSpan(
                    text: 'A partir del 01 de enero de 2024.',
                    style: TextStyle(color: Colors.black)
                ),
              ),
            ]
        ).paddingAll(20),
      ),
    );
  }
}
