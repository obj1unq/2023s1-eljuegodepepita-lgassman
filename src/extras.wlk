import wollok.game.*
import pepita.*

object screen {
	
	method validarPuedeIr(position) {
		if (not self.puedeIr(position)) {
			self.error("No puedo ir ahí")
		}
	}
	
	method dentro(position) {
		return position.x().between(0, game.width()-1) and
				position.y().between(0, game.height()-1)
	}
	
	method puedeIr(position) {
		return self.dentro(position) and not self.hayCosasNoAtravesables(position)
	}
	
	method hayCosasNoAtravesables(position) {
		return game.getObjectsIn(position).any({x => not x.atravesable()})
	}
	
	method mover(objeto, position) {
		self.validarPuedeIr(position)
		objeto.position(position)
	}
}

class Muro {
	
	var property position
	var property image = "muro.png"
	
	const property atravesable = false
	
}



//Quedo codigo duplicado que se tiene que reparar cuando sepamos herencia
object arriba  {
	
	method proxima(objeto, cantidad) {
		return objeto.position().up(cantidad)
	}
	
	method mover(objeto, cantidad) {
		self.validarMover(objeto,cantidad)
		screen.mover(objeto, self.proxima(objeto, cantidad))
	}
	
	method puedeMover(objeto, cantidad) {
		return screen.puedeIr(self.proxima(objeto, cantidad))
	}
	
	method validarMover(objeto, cantidad) {
		screen.validarPuedeIr(self.proxima(objeto, cantidad))
	}
		
}

object abajo {
	method proxima(objeto, cantidad) {
		return objeto.position().down(cantidad)
	}
	
	method mover(objeto, cantidad) {
		self.validarMover(objeto,cantidad)
		screen.mover(objeto, self.proxima(objeto, cantidad))
	}
	
	method validarMover(objeto, cantidad) {
		screen.validarPuedeIr(self.proxima(objeto, cantidad))
	}
	
	method puedeMover(objeto, cantidad) {
		return screen.puedeIr(self.proxima(objeto, cantidad))
	}
	
}

object izquierda {
	method proxima(objeto, cantidad) {
		return objeto.position().left(cantidad)
	}
	
	method mover(objeto, cantidad) {
		self.validarMover(objeto,cantidad)
		screen.mover(objeto, self.proxima(objeto, cantidad))
	}
	
	method validarMover(objeto, cantidad) {
		screen.validarPuedeIr(self.proxima(objeto, cantidad))
	}
	
	method puedeMover(objeto, cantidad) {
		return screen.puedeIr(self.proxima(objeto, cantidad))
	}
	
	
}

object derecha {
	
	method proxima(objeto, cantidad) {
		return objeto.position().right(cantidad)
	}
	
	method mover(objeto, cantidad) {
		self.validarMover(objeto,cantidad)
		screen.mover(objeto, self.proxima(objeto, cantidad))
	}
	
	method validarMover(objeto, cantidad) {
		screen.validarPuedeIr(self.proxima(objeto, cantidad))
	}
	
	method puedeMover(objeto, cantidad) {
		return screen.puedeIr(self.proxima(objeto, cantidad))
	}
	
			
}


object silvestre {
	
	var property objetivo = pepita
	const property atravesable = true
	
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
	const property atravesable = true
	method image() {return "nido.png"}
	
	method chocar(personaje) {
		pepita.ganar()
	}
}

