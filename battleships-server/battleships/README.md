# Battleships

## executing

```stack build```

```stack stack exec battleships-exe```

Will be asked to enter a gameId and a playerId ('A' or 'B')

## Tests

```stack test```


## Configuration

game url defined at `src/network/HttpConnector.hs` as `baseUrl`

some tests at `test/Spec.hs` are commented out since they are using network and were used in development