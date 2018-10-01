defmodule Dunia.Utils.TypedStruct do
  @moduledoc """
  Credit [Tymon Tobolski](https://gist.github.com/teamon/b90a2ddca4965848559a96aff49ed9bb)
  Define module with struct and typespec, in single line.

  #### Thus
  ```
  alias Dunia.Utils.TypedStruct
  defmodule User do
    use TypedStruct, name: String.t
    deftypedstruct  Phone, numbers: list(integer)
  end

  ```

  #### will result in:

  ```
  defmodule User do
    defstruct [:name]
    @enforce_keys [:name]
    @type t :: %User{
      name: String.t
    }

    defmodule Phone do
      defstruct [:numbers]
      @enforce_keys [:numbers]
      @type t :: %Phone{
        numbers: [String.t]
      }

    end

  end
  ```
  """

  defp splice_attributes(attrs) do
    keys = Keyword.keys(attrs)

    quote do
      @enforce_keys unquote(keys)
      defstruct @enforce_keys

      @type t :: %__MODULE__{
              unquote_splicing(attrs)
            }
    end
  end

  @doc """
  Example:
  defmodule User do
    import StructTyping
    deftypedstruct id:   integer,
    name: String.t

    deftypedstruct Friends,
    id:   integer,
    name: String.t

  end
  """

  defmacro deftypedstruct(module \\ nil, attrs) do
    quote do
      import Dunia.Utils.TypedStruct

      case unquote(module) do
        nil ->
          unquote(splice_attributes(attrs))

        x when is_atom(x) ->
          defmodule unquote(module) do
            unquote(splice_attributes(attrs))
          end
      end
    end
  end

  defmacro __using__(attrs) do
    quote do: Dunia.Utils.TypedStruct.deftypedstruct(nil, unquote(attrs))
  end
end
