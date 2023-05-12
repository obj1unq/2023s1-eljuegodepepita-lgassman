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
	
}


object libre {
	method iniciar() {
		
	}
	
	method validarMover(){
				
	}
}


object pepita {

	var property energia = 100
	var property position = game.at(0, 5)
	var property perseguidor=silvestre
	
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
	
	method desplazar(direccion, cantidad) {
		direccion.mover(self, cantidad)
	}
	
	method mover(direccion, cantidad) {
		self.estado().validarMover()
		self.volar(cantidad)
		self.desplazar(direccion, cantidad)
		if (self.debil()) {
			self.perder()
		}
	}

	
	method caer() {
		self.desplazar(abajo, 1)
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

