import wollok.game.*
import randomizer.*

object manzanaFactory {
	
	method nuevo() {
		return new Manzana(position = randomizer.emptyPosition())
	}
}

object alpisteFactory {
	
	method nuevo() {
		return new Alpiste(position = randomizer.emptyPosition(), peso = (40..100).anyOne())
	}
}


object alimentoManager {
	
	const generadas = #{}
	const limite = 3
	const factories = [manzanaFactory, alpisteFactory]
	
	method generar() {
		if(generadas.size() < limite) {
			const alimento = self.nuevoAlimento()	
			game.addVisual(alimento)
			generadas.add(alimento)
		}
	}
	
	method eliminar(alimento) {
		game.removeVisual(alimento)
		generadas.remove(alimento)
	}
	
	method elegirFactory() {
//		 const index = if (0.randomUpTo(1) < 0.45) {1} else {0}
//		 return factories.get(index)
	     return factories.anyOne()  
	}

	method nuevoAlimento() {
		return self.elegirFactory().nuevo()
	}
	
}

class Manzana {
	const base= 5
	var madurez = 1
	
	const property atravesable = true
	
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
		alimentoManager.eliminar(self)
	}

}

class Alpiste {
	var property position = game.at(3,4)
	const peso = 10
	const property atravesable = true
	
	method image() { return "alpiste.png" }

	method energiaQueOtorga() {
		return peso
	}
	 
//	method comido() {
//		game.removeVisual(self)
//	}

	method chocar(personaje) {
		personaje.comer(self)
		alimentoManager.eliminar(self)
	}
	

}

