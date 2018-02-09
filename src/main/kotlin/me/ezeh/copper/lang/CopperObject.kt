package me.ezeh.copper.lang

abstract class CopperObject : CopperValue() {
    abstract fun getVariable(name: String): CopperValue
    abstract fun setVariable(name: String, value: CopperExpression)
    abstract fun getMethod(name: String, value: CopperExpression): CopperMethod
}