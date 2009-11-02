formats = { 
  :update => "%a %d %b %I:%M %p" ,
  :day => "%d/%m/%Y"
}

formats.each do |name, format|
  DateTime::DATE_FORMATS[name] = format
  Time::DATE_FORMATS[name] = format
end