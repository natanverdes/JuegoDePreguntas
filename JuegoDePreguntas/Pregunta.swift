//
//  Pregunta.swift
//  JuegoDePreguntas
//
//  Created by  on 3/11/15.
//  Copyright © 2015 Natán Verdés. All rights reserved.
//

import Foundation

class Pregunta{
    var pregunta: String
    var respuestas: [String]
    var respuestaCorrecta: Int

    init(pregunta: String, respuestas: [String], respuestaCorrecta: Int){
        self.pregunta = pregunta;
        self.respuestas = respuestas;
        self.respuestaCorrecta = respuestaCorrecta;
    }
}