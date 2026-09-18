import * as React from "react"; import {cn} from "@/lib/utils";
export function Card({className,...p}:React.HTMLAttributes<HTMLDivElement>){return <div className={cn("rounded-2xl border bg-white shadow-premium",className)} {...p}/>}
export function CardContent({className,...p}:React.HTMLAttributes<HTMLDivElement>){return <div className={cn("p-6",className)} {...p}/>}