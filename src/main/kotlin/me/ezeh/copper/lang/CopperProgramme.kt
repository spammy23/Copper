package me.ezeh.copper.lang

class CopperProgramme(val info: CopperInfo, val expressions: List<CopperExpression>) : CopperExpression {
    val environment = CopperEnvironment()

    fun execute(): CopperExpression {
        for (expression in expressions) {
            expression.evaluate()
        }
        return this
    }

}
