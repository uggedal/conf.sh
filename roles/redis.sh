redis_role() {
  pkg add redis &&
    daemon enable redis &&
    daemon start redis
}
