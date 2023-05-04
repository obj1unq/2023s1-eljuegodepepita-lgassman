import wollok.game.*

object manzana {
	const base= 5
	var madurez = 1
	
	var property position = game.at(5,9)
	
	method image() { return "manzana.png" }
	
	method energiaQueOtorga() {
		return base * madurez	
	}
	
	method madurar() {
		madurez = madurez + 1
	}
		
	method chocar(personaje) {
		personaje.comer(self)
		game.removeVisual(self)
	}

}

object alpiste {
	var property position = game.at(3,4)
	
	method image() { return "alpiste.png" }

	method energiaQueOtorga() {
		return 20
	}
	 
//	method comido() {
//		game.removeVisual(self)
//	}

	method chocar(personaje) {
		personaje.comer(self)
		game.removeVisual(self)
	}
	

}

