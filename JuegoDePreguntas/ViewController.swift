//
//  ViewController.swift
//  JuegoDePreguntas
//
//  Created by  on 3/11/15.
//  Copyright © 2015 Natán Verdés. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var pregunta: UILabel!
    @IBOutlet weak var respuesta1: UIButton!
    @IBOutlet weak var respuesta2: UIButton!
    @IBOutlet weak var respuesta3: UIButton!
    @IBOutlet weak var respuesta4: UIButton!
    
    var defaultButtonColor: UIColor?
    
    var puntuacion: Int = 0
    var indicePreguntaActual: Int?
    var preguntasDefault: [Pregunta] = [
        Pregunta(pregunta: "¿Cual es la capital de España?", respuestas: ["Barcelona", "Madrid", "Valencia", "Girona"], respuestaCorrecta: 2),
        Pregunta(pregunta: "¿Quien fue el arquitecto de la Sagrada Familia?", respuestas: ["Armancio Ortega", "Gerard Piqué", "Mark Zuckemberg", "Gaudí"], respuestaCorrecta: 4),
        Pregunta(pregunta: "¿Quién fundó facebook?", respuestas: ["Mark Zuckemberg", "Steve Jobs", "Ada Colau", "Daenerys Targaryen"], respuestaCorrecta: 1),
        Pregunta(pregunta: "¿Cuántos años tenía Steve Jobs cuando fundó Apple?", respuestas: ["20", "19", "28", "21"], respuestaCorrecta: 4),
        Pregunta(pregunta: "¿Cual fué el motivo principal por el que se quiso fundar 4chan?", respuestas: ["Permitir publicaciones irrastreables", "Compartir música con copyright", "Debatir sobre cómics japoneses y anime", "Hacer una base de datos de imágenes gore"], respuestaCorrecta: 3)
    ]
    var preguntasJuego: [Pregunta]!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        preguntasJuego = preguntasDefault
        defaultButtonColor = respuesta1.backgroundColor
        cargarPregunta()
    }

    
    override func viewDidAppear(animated: Bool) {
        // Cargamos configuración de usuario
        let showTutorial = NSUserDefaults.standardUserDefaults().boolForKey("SettingsShowTutorialOnLaunch")
        if(showTutorial){
            let alertView: UIAlertController = UIAlertController(title: "Instrucciones", message: "Selecciona la respuesta correcta de cada pregunta. Cada acierto te dará 1 punto. Pasas a la siguiente pregunta al contestar la anterior, aciertes o falles.", preferredStyle: .Alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .Default, handler: nil)
            alertView.addAction(aceptar)
            self.presentViewController(alertView, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func buttonTouchUpInside(sender: UIButton) {
        // Eliminar toda actividad de usuario con botones
        respuesta1.userInteractionEnabled = false
        respuesta2.userInteractionEnabled = false
        respuesta3.userInteractionEnabled = false
        respuesta4.userInteractionEnabled = false
        
        // Buscamos la pregunta actual
        let preguntaActual = preguntasJuego![self.indicePreguntaActual!]

        // Si es correcto
        if(sender.titleLabel!.text == preguntaActual.respuestas[preguntaActual.respuestaCorrecta-1]){
            sender.backgroundColor = UIColor.greenColor()
            self.puntuacion++
        }
        
        // Si no es correcto
        else{
            // Ponemos en rojo el botón actual
            sender.backgroundColor = UIColor.redColor()
            
            // Ponemos en verde la respuesta correcta
            let botonesRespuestas = [respuesta1, respuesta2, respuesta3, respuesta4]
            for var index = 0; index < botonesRespuestas.count; ++index{
                if(botonesRespuestas[index].titleLabel!.text == preguntaActual.respuestas[preguntaActual.respuestaCorrecta-1]){
                    botonesRespuestas[index].backgroundColor = UIColor.greenColor()
                }
            }
            
        }
        
        self.preguntasJuego.removeAtIndex(self.indicePreguntaActual!)
        // TODO Esperamos un segundo
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("botonDespuesEspera"), userInfo: nil, repeats: false)

    }
    func botonDespuesEspera(){
        // TODO Cargamos una pregunta nueva
        cargarPregunta()
    
        // Devolvemos actividad de usuario a los botones
        respuesta1.backgroundColor = defaultButtonColor
        respuesta2.backgroundColor = defaultButtonColor
        respuesta3.backgroundColor = defaultButtonColor
        respuesta4.backgroundColor = defaultButtonColor
    
        respuesta1.userInteractionEnabled = true
        respuesta2.userInteractionEnabled = true
        respuesta3.userInteractionEnabled = true
        respuesta4.userInteractionEnabled = true
    }
    
    func cargarPregunta(){
        if(preguntasJuego!.isEmpty){
            // Ir a pantalla de resultados
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("winner") as! WinnerViewController
            vc.puntuacion = self.puntuacion
            
            let topController = UIApplication.sharedApplication().keyWindow!.rootViewController
            topController!.dismissViewControllerAnimated(true, completion: nil)
            topController!.presentViewController(vc, animated: true, completion: nil)
            
            // Reiniciar Juego
            preguntasJuego = preguntasDefault
            puntuacion = 0
            self.cargarPregunta()
            
        }else{
            // Seleccionamos pregunta
            let randomIndex = Int(arc4random_uniform(UInt32(preguntasJuego.count)))
            self.indicePreguntaActual = randomIndex
            
            // Y la cargamos
            self.pregunta.text = self.preguntasJuego[self.indicePreguntaActual!].pregunta
            
            self.respuesta1.setTitle(self.preguntasJuego[self.indicePreguntaActual!].respuestas[0], forState: .Normal)
            self.respuesta2.setTitle(self.preguntasJuego[self.indicePreguntaActual!].respuestas[1], forState: .Normal)
            self.respuesta3.setTitle(self.preguntasJuego[self.indicePreguntaActual!].respuestas[2], forState: .Normal)
            self.respuesta4.setTitle(self.preguntasJuego[self.indicePreguntaActual!].respuestas[3], forState: .Normal)

        }
    }
    

    
    func cargarPregunta(pregunta: Pregunta){
        
    }
    func comprobarPregunta(pregunta: Pregunta){
        
    }
    

}

