# social_network_system_design
ДЗ курса по [System Design](https://balun.courses/courses/system_design)
# Социальная сеть для путешественников "Travel shots"
_Специальная социальная сеть для путешественников
Будущая аудитория социальной сети - у бизнеса есть огромные средства для рекламы и продвижения социальной
сети, поэтому пользовательская база будет постепенно линейно расти и через год достигнет примерно 10 000 000 уникальных
пользователей в день, после чего также будет продолжать расти. Бизнес пока нацелен  только на аудиторию стран СНГ
(на зарубежный рынок выходить планов нет). Будущая система должна быть очень надежной, а также, чтобы с ней было удобно
взаимодействовать, используя мобильные устройства и браузер._

## Функциональные требования

- публикация постов из путешествий с фотографиями, небольшим описанием и привязкой к конкретному месту путешествия;
- оценка и комментарии постов других путешественников;
- подписка на других путешественников, чтобы следить за их активностью;
- поиск популярных мест для путешествий и просмотр постов с этих мест в виде ТОПа мест по странам и городам;
- общение с другими путешественниками в личных сообщениях;
- просмотр ленты других путешественников;
- взаимодействие с сетью, используя мобильные устройства и браузер.

## Нефункциональные требования

- **Аудитория приложения**
    - Количество пользователей
      > - Какое количество пользователей (DAU / MAU) ожидается в будущем приложении, а также, как оно будет расти?
        - 10 000 000 DAU
        - 65 000 000 MAU (Население СНГ ~240млн. человек)
      
    - Поведение пользователей

      > - Сколько один пользователь в день будет, в среднем, создавать запросов к будущему приложению?
        - Один пользователь, в среднем, будет делать 8 запросов в день к приложению:
          - 3 Просмотр ленты постов 
          - 1 Просмотр комментариев 
          - 3 Просмотр сообщений (синхронизация)
          - 0,6 Отправка сообщений
          - 0,3 Отправка комментария
          - 0,1 Отправка поста
      >
    - Регионы использования приложения

      > - На аудиторию каких регионов/стран будет запущено будущее приложение?
        - Только на СНГ.
      >
- **Особенности приложения**
    - Сезонности в приложении

      > - Будут ли сезонности, когда приложением в определенный период будут использовать большое количество пользователей?
        - Да, природная сезонность, а также государственные и религиозные календари. 
        Считаем от средней нагрузки за год: 
          - +15% в период школьных каникул, 
          - +50% Новогодние, майские праздники, 
          - +25% периоды цветения 
          - +15% религиозные праздники, время паломничества.
      >
    - Условия хранения данных

      > - Данные храним всегда, либо можно удалять/агрегировать какие-либо данные спустя какое-либо время?
        - Храним всегда.
      >
    - Лимиты и ограничения

      > - Если делаем подписки, то какое максимальное количество подписчиков может быть у пользователя?
        - 10 000 000 подписчиков.
      > - Частота ошибок: 
        - Менее 0,4% запросов должны приводить к ошибкам. 0,05% - по доступности приложения. 0,35% - запланированные ошибки, например,  не более 100 постов в день. ограничения по размеру фото.. Система при наличии ограничений должна сама убирать возможность отправки (неативная кнопка до истечения блокировки), дабы не вынуждать пользователя делать ошибочный запрос и получать ошибку в ответ. Также и с ограничением по размеру файла - вместо попытки загрузки на сервер можно вывести предупреждение.
          В общем итоге это улучшает пользовательский опыт и снижает нагрузку на сервер.

    - Временные ограничения

      > - Время отклика? 
       - Запросы на чтение должны быть выполнены в течение 150 мс
       - Запросы на запись должны быть выполнены в течение 800 мс

      > - Доступность приложения. Сколько по времени приложение может быть недоступно за год?
        - Не более, чем несколько часов простоя в год. ~99,95%
  
    - Безопасность
      > - Защита (Шифрование) пользовательских данных от несанкционированного доступа.
      > - Безопасные методы аутентификации пользователя
    
    - Масштабируемость
      > - Поддержка горизонтального масштабирования и способность выдерживать нагрузку при влиянии сезонности.  

## Оценка нагрузки
- **Расчет RPS = dau * avg_requests_per_day_by_user / 86 400**
    
  > - RPS = 10 000 000 * 8 / 86 400 = 926
  > - Просмотр ленты постов - 3.   RPS = 10_000_000 * 3 / 86_400 = 347
  > - Просмотр комментариев - 1.   RPS = 10_000_000 * 1 / 86_400 = 115
  > - Просмотр сообщений (синхронизация) - 3. RPS = 10_000_000 * 3 / 86_400 = 347
  > - Отправка сообщений - 0,6.    RPS = 10_000_000 * 0,6 / 86_400 = 69,4
  > - Отправка комментария - 0,3.  RPS = 10_000_000 * 0,3 / 86_400 = 34,7
  > - Отправка поста - 0,1.        RPS = 10_000_000 * 0,1 / 86_400 = 11,5

      
- **Расчет Traffic = rps * avg_request_size**
  > - С учетом использования внешнего хранилища для файлов с CDN, средний размер запроса будет составлять 4КБ
  > - Traffic = 926 * 4КБ = 3704 КБ/с

- **Расчет одновременных соединений = dau * 0.1**
  > - Connections = 10 000 000 * 0.1 = 1 000 000
