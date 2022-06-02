FROM swipl
COPY semweb_query_Lihogub.pl semweb_query_Lihogub.pl
COPY mappingbased-objects_lang=ru.ttl mappingbased-objects_lang=ru.ttl
CMD ["swipl", "semweb_query_Lihogub.pl"]
