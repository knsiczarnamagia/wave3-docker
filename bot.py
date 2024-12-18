from dotenv import load_dotenv
import os
import discord
from discord.ext import commands

load_dotenv()
token = os.getenv("TOKEN")

intents = discord.Intents.default()
intents.message_content = True  # Pozwala odczytać treść wiadomości
intents.guilds = True           # Dostęp do informacji o serwerze i kanałach
intents.members = True          # Dostęp do listy członków

# Tworzenie instancji bota
bot = commands.Bot(command_prefix="!", intents=intents)

# Informacja o udanym logowaniu bota
@bot.event
async def on_ready():
    print(f"Bot zalogowany jako: {bot.user}")

# Przykładowa komenda na którą bot zareaguje
@bot.command()
async def hello(ctx):
    await ctx.send("Cześć! Jestem gotowy do pracy!")

# Uruchomienie bota
bot.run(token)
