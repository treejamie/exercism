defmodule RPG do
  defmodule Character do
    @type t :: %Character{health: number(), mana: number()}
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    @type t :: %ManaPotion{strength: number()}
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    @spec eat(item :: any(), character :: Character.t()) ::
            {any(), Character.t()}
    def eat(loaf, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(_item, character) do
      {nil, %Character{character | health: character.health + 5}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(item, character) do
      {%RPG.EmptyBottle{}, %Character{character | mana: character.mana + item.strength}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(_item, character) do
      {%RPG.EmptyBottle{}, %Character{character | health: 0}}
    end
  end
end
