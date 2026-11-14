return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- Evita que se dilate la carga del tema al arrancar
    priority = 1000, -- Asegura que se cargue antes que otros plugins
    opts = {
      transparent = true, -- Cambia a true si deseas un fondo transparente
      dimInactive = true, -- Atenúa el brillo de las ventanas inactivas
      theme = "dragon", -- Elige tu variante: "wave", "dragon" o "lotus"
      background = {
        dark = "wave", -- Variante oscura predeterminada
        light = "lotus", -- Variante clara al usar :set background=light
      },
    },
  },
}
