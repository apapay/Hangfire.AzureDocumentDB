﻿using Hangfire.Storage;
using System.Threading;

// ReSharper disable once CheckNamespace
namespace Hangfire.Azure.Queue
{
    internal interface IPersistentJobQueue
    {
        IFetchedJob Dequeue(string[] queues, CancellationToken cancellationToken);
        void Enqueue(string queue, string jobId);
    }
}
