class Personaje {
  const fuerza
  const inteligencia
  var property rol
  method potencialOfensivo() = fuerza * 10 + rol.extra()
  method esGroso() = self.esInteligente() || self.esGrosoEnSuRol()
  method esInteligente()
  method esGrosoEnSuRol() = rol.esGroso(self)
}

class Orco inherits Personaje {
  override method potencialOfensivo() = if(rol == brujo) super() * 1.1 else super()
  override method esInteligente() = false
}
class Humano inherits Personaje {
  override method esInteligente() = inteligencia > 50
}

object guerrero {
  method extra() = 100
  method esGroso(unPersonaje) = unPersonaje.fuerza() > 50
}
class Cazador {
  const property mascota
  method extra() = mascota.extra()
  method esGroso(unPersonaje) = mascota.esLongeva() 
}
object brujo {
  method extra() = 0
  method esGroso(unPersonaje) = true
}

class Mascota {
  const property fuerza
  var edad
  const property tieneGarras
  method cumplirAños(){
    edad += 1
  }
  method extra() = if(tieneGarras) fuerza * 2 else fuerza
  method esLongeva() = edad > 10
}

class Localidad {
  var ejercito
  method ejercito() = ejercito
  method poderDefensivo() = ejercito.poderOfensivo()
  method serOcupada(unEjercito)
}
class Aldea inherits Localidad{
  const cantHabitanesMaxima
  override method serOcupada(unEjercito){
    if(unEjercito.personajes().size() > cantHabitanesMaxima) {
      ejercito = unEjercito.ejercitoMasFuertes()
    }
    else {
      ejercito = unEjercito
    }
  }
}
class Ciudad inherits Localidad{
  override method poderDefensivo() = super() + 300
  override method serOcupada(unEjercito){
    ejercito = unEjercito
  }
}

class Ejercito {
  const property personajes = []
  method invadir(unaLocalidad){
    if(self.puedeTomarLocalidad(unaLocalidad)) {
      unaLocalidad.serOcupada(self)
    }
  }
  method poderOfensivo() = personajes.sum({p => p.potencialOfensivo()})
  method puedeTomarLocalidad(unaLocalidad) = self.poderOfensivo() > unaLocalidad.poderDefensivo()
  method ejercitoMasFuertes() = self.masPoderosos().take(10)
  method masPoderosos() = personajes.sortBy({p1,p2 => p1.potencialOfensivo() > p2.potencialOfensivo()})
}