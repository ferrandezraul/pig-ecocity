class Pig
  attr_reader :orelles
  attr_reader :galtes
  attr_reader :cinta_llom
  attr_reader :magre_coll
  attr_reader :pit
  attr_reader :costellam
  attr_reader :cansalada
  attr_reader :espatlla
  attr_reader :brao
  attr_reader :peus
  attr_reader :cua
  attr_reader :llardo

  def initialize()
    @orelles = 2    # Unitats
    @galtes = 2     # Unitats
    @peus = 4       # Unitats
    @cua = 1        # Unitats
    @cinta_llom = 4 # kg
    @magre_coll = 4 # kg
    @pit = 4        # kg
    @costellam = 4  # kg
    @cansalada = 4  # kg
    @espatlla = 4   # kg
    @brao = 4       # kg
    @llardo = 4     # kg
  end

  def to_s
    "Orelles: #{@orelles}\nGaltes #{@galtes}\nPeus: #{@peus}\nCua: #{@cua}\nCinta Llom: #{@cinta_llom} kg\nMagre de coll: #{@magre_coll} kg\nPit: #{@pit} kg\n"
  end

end