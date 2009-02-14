Host.fix {{
  :address => DataMapper::Sweatshop.unique { /\w+/.gen }
}}

Host.fix(:local) {{
  :address => "localhost:11211"
}}