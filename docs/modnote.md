# 📓 Notes for Future Modders

## 1. Damage Absorption Calculation Sequence

1. `damage = target.components.inventory:ApplyDamage(damage, attacker, weapon)`
    * Only take the maximum defense among all equipments
2. `damage = damage * target.components.combat.externaldamagetakenmultipliers:Get()`
    * Product of all externaldamagetakenmultipliers
3. `damage = (damage + attacker.components.combat.bonusdamagefn(attacker, target, damage, weapon))`
    * Bonus damage ignores armors
4. `damage = damage * math.clamp(1 - target.components.health.externalabsorbmodifiers:Get(), 0, 1)`
    * **Sum** of all externalabsorbmodifiers, so be careful when using this
    * Affected by `Health:DoDelta(..., ignore_invincible, ignore_absorb)`
    * Only cannot absorb damage caused by drown and building health-consuming recipes
    * This is the final step, thus where to deal a real damage

## 2. Listen for events from other entity

1. `EntityScript:ListenForEvent(event, fn, source)`
   * Add source parameter to add event listener to other entity, used in manashield and debuffs
   * Works like source:ListenForEvent(event, fn), fn's inst = source instead of entity itself
   * When entity is removed, all listeners added by it to source will be removed automatically

## 3. SendModRPCToServer and AddModRPCHandler

1. `SendModRPCToServer(MOD_RPC.namespace.name, param1, param2, ...)`
   * All params in this function call must be simple values (string, number, etc), table is not accepted
   * If a table is passed into the param list, handler function on server side will not be invoked
   * Except for all params passed when calling `SendModRPCToServer`, the handler fn will always take the server side entity of `ThePlayer` as the first param depending on from which player's client the RPC is sent. So the handler fn should be defined as `Handler(inst, param1, param2, ...)`

## 4. Components loading sequence

1. For an entity, all its `Component.OnLoad` are called by the order of when the corresponding `inst:AddComponent()` was called
