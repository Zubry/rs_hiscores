# RsHiscores

RunescapeHiscores
  * PlayerList
    * Stores usernames to check
      * ModuleA.get() -- Returns a list of usernames to check
  * PlayerProducer
    * GenStage that produces usernames to check
  * PlayerFetcher
    * Loads data from the hiscores
  * PlayerConsumer
    * Broadway consumer that consumes ModuleB and calls ModuleC on each message
    * Broadway controls rate limiting & concurrency
  * PlayerStore
    * Stores results from ModuleD

