function spell_matches_weather(spell)
  return (spell.element == world.weather_element) or (spell.element == world.day_element);
end
