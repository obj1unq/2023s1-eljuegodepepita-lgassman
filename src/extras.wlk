import wollok.game.*
import pepita.*

object screen {
	
	method validarDentro(position) {
		if (not self.dentro(position)) {
			self.error("No puedo salir de la pantalla")
		}
	}
	
	method dentro(position) {
		return position.x().between(0, game.width()-1) and
				position.y().between(0, game.height()-1)
	}
	
	method mover(objeto, position) {
		if(self.dentro(position)){
			objeto.position(position)
		}		
	}
}


object arriba {
	
	method mover(objeto, cantidad) {
		screen.mover(objeto, objeto.position().up(cantidad))
	}
}

object abajo {
	method mover(objeto, cantidad) {
		screen.mover(objeto, objeto.position().down(cantidad))
	}
}

object izquierda {
	method mover(objeto, cantidad) {
		screen.mover(objeto, objeto.position().left(cantidad))
	}
}

object derecha {
	method mover(objeto, cantidad) {
		screen.mover(objeto, objeto.position().right(cantidad))
	}		
}


object silvestre {
	
	var property objetivo = pepita
	
	method position() {
		return game.at( 3.max(objetivo.position().x()) , 0 )		
	}
	
	method image() {
		return "silvestre.png"	
	}
	
	method chocar(personaje) {
		pepita.perder()
	}
	
	
}

object nido {
	
	var property position = game.at(14, 7)
	method image() {return "nido.png"}
	
	method chocar(personaje) {
		pepita.ganar()
	}
}

