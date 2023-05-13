import wollok.game.*
import extras.*


object derrotada {
	method iniciar() {
		game.say(pepita, "Perdi")
		game.removeTickEvent("GRAVEDAD")
		game.schedule(3000, {game.stop()})
	}
	
	method validarMover(){
		self.error("Ya perdí che!")		
	}
	method puedeMover() {
		return false
	}
}

object ganadora {
	method iniciar() {
		game.say(pepita, "Gané")
		game.removeTickEvent("GRAVEDAD")
		game.schedule(3000, {game.stop()})
	}
	
	method validarMover(){
		self.error("Pa' qué si ya gané ")		
	}
	method puedeMover() {
		return false
	}
	
}


object libre {
	method iniciar() {
		
	}
	
	method validarMover(){
				
	}
	
	method puedeMover() {
		return true
	}
	
}


object pepita {

	var property energia = 100
	var property position = game.at(0, 5)
	var property perseguidor=silvestre
	
	const property atravesable = true
	
	var estado = libre

	method image() {
		return "pepita-" + self.estado().toString() + ".png"
	}
	
	method text() {
		return energia.toString()
	}
	
	method textColor() {
		return "ff0000ff"
	}
	
	method estado() {
		return estado
	}
	
	method debil() {
		return not self.puedeVolar(1)
	}
	
	method atrapada() {
		return position == perseguidor.position()
	}

	method comer(comida) {
		energia = energia + comida.energiaQueOtorga()
	}

	method validarVolar(kms) {
		if (not self.puedeVolar(kms)) {
			self.error("no puedo volar")
		}
	}
	
	method puedeVolar(kms) {
		return energia >= self.energiaParaVolar(kms)
	}
	
	method energiaParaVolar(kms) {
		return 10 + kms
	} 
	
	method volar(kms) {
		self.validarVolar(kms)
		energia = energia - self.energiaParaVolar(kms)
	}
	
	method validarDesplazar(direccion, cantidad) {
		direccion.validarMover(self, cantidad)
	}
	method desplazar(direccion, cantidad) {
		direccion.mover(self, cantidad)
	}
	
	method puedeMover(direccion, cantidad) {
		return estado.puedeMover() and direccion.puedeMover(self, cantidad)
	}
	
	method moverSiPuede(direccion, cantidad) {
		if (self.puedeMover(direccion, cantidad)) { 			
			self.volar(cantidad)
			self.desplazar(direccion, cantidad)
			if (self.debil()) {
				self.perder()
			}		
		}
	}

	
	method caer() {
		if (abajo.puedeMover(self,1)) {
			self.desplazar(abajo, 1)
		}
	}
	
	method energia() {
		return energia
	}
	
	
	method estado(_estado) {
		estado =_estado
		estado.iniciar()
	}
	
	method ganar() {
		self.estado(ganadora)
	}
	
	method perder() {
		self.estado(derrotada)
	}

}

