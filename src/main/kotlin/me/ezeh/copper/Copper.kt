package me.ezeh.copper

import me.ezeh.copper.plugin.CopperPluginLoader
import org.bukkit.plugin.java.JavaPlugin
import java.io.File

class Copper : JavaPlugin() {
    private val scriptDirectory = File(dataFolder, "scripts")

    override fun onEnable() {
        if (!scriptDirectory.exists())
            if (!scriptDirectory.mkdirs()) {
                logger.severe("Could not create 'scripts' directory, disabling")
                server.pluginManager.disablePlugin(this)
            }


        val scripts = scriptDirectory.listFiles().filter { it.name.endsWith(".cp") }
        for (script in scripts) {
            val plugin = CopperPluginLoader(scriptDirectory).loadPlugin(script)
            println("Loaded '${plugin.name}'")
        }

    }

    override fun onDisable() {

    }


}