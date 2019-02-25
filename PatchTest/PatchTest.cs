using System;
using System.Diagnostics;
using RimWorld;
using Verse;

namespace LWM.PatchTest {
    public class TimeMessage : PatchOperation {
        public static Stopwatch stopwatch;

        protected override bool ApplyWorker(System.Xml.XmlDocument xml) {
            if (command == Command.Start) {
                stopwatch = new Stopwatch();
                if (message == "") {
                    message = "Stopwatch starting at time " + DateTime.Now;
                } else {
                    message += " (" + DateTime.Now + ")";
                }
                Log.Warning(message);
                return true;
            }
            if (command == Command.TimeNow) {
                if (message == "") {
                    message = "Time is currently " + DateTime.Now;
                } else {
                    message += " (" + DateTime.Now + ")";
                }
                Log.Warning(message);
                return true;
            }
            if (command == Command.Stop) {
                stopwatch.Stop();
                TimeSpan ts = stopwatch.Elapsed;
                string elapsedTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",
                    ts.Hours, ts.Minutes, ts.Seconds,
                    ts.Milliseconds / 10);
                if (message == "") {
                    message = "Stopwatch stopping at time " + DateTime.Now;
                } else {
                    message += " (" + DateTime.Now + ")";
                }
                Log.Warning(message);
                Log.Error("Time elapsed: " + elapsedTime);
                return true;
            }
            Log.Error("LWM: Patch Test: unknown command?");
            return false;
        }
        protected string message="";
        protected Command command;
    }
    public enum Command : byte {
        Start,
        TimeNow,
        Stop,
    }
}
